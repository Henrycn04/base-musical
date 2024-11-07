using backend.Models;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;
using Dapper;

namespace backend.Handlers
{
    public class CategoriasHandler
    {
        private SqlConnection _conexion;
        private string _rutaConexion;
        public CategoriasHandler()
        {
            var builder = WebApplication.CreateBuilder();
            _rutaConexion = builder.Configuration.GetConnectionString("DBContext");
            _conexion = new SqlConnection(_rutaConexion);
        }

        // Método para obtener categorías sin padre (padre_id nulo)
        public async Task<List<CategoriasModel>> ObtenerCategoriasSinPadre()
        {
            const string query = "SELECT * FROM Categorias WHERE padre_id IS NULL";

            using (var connection = _conexion)
            {
                await connection.OpenAsync();
                var categorias = await connection.QueryAsync<CategoriasModel>(query);
                return categorias.AsList();
            }
        }

        // Método para obtener categorías por PadreId
        public async Task<List<CategoriasModel>> ObtenerCategoriasPorPadreId(List<int> padres) //TODO: podria agregarle un int de nivel a cada categoria
        {
            // Asegurarse de que la lista de IDs no esté vacía
            if (padres == null || !padres.Any())
            {
                return new List<CategoriasModel>();
            }

            // Construir la consulta con parámetros
            string query = "SELECT * FROM Categorias WHERE padre_id IN @PadreIds";

            using (var connection = _conexion)
            {
                await connection.OpenAsync();

                // Usar parámetros para evitar inyección SQL
                var categorias = await connection.QueryAsync<CategoriasModel>(query, new { PadreIds = padres });

                return categorias.AsList();
            }
        }
        // falta el metodo que devuelve los ejemplos musicales, usar distinct

    }
}
