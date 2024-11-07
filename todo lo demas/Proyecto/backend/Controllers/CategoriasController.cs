using Azure;
using backend.Handlers;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace backend.Controllers
{
    [ApiController]
    [Route("api/categorias")]
    public class CategoriasController : ControllerBase
    {
        private readonly CategoriasHandler _categoriasHandler;

        public CategoriasController()
        {
            _categoriasHandler = new CategoriasHandler();
        }

        // Endpoint para obtener todas las categorías sin padre (padre_id nulo)
        [HttpGet("sin-padre")]
        public async Task<IActionResult> GetCategoriasSinPadre()
        {
            List<CategoriasModel> categorias = await _categoriasHandler.ObtenerCategoriasSinPadre();
            return Ok(categorias);
        }

        // Endpoint para obtener categorías por PadreId
        [HttpGet("por-padre")] // si hay varias selecciones usar la solicitud del checkmark, trabajar con distinct
        public async Task<IActionResult> GetCategoriasPorPadreId([FromQuery] List<int> padres)
        {
            Console.WriteLine("Request:");
            Console.WriteLine(Request.QueryString.Value);
            Console.WriteLine("Lista de padres:");
            foreach (var padre in padres)
            {
                
                Console.WriteLine(padre);  // Imprime cada valor en la consola
            }
            List<CategoriasModel> categorias = await _categoriasHandler.ObtenerCategoriasPorPadreId(padres);
            Console.WriteLine("Lista de hijos:");
            foreach (var cate in categorias)
            {
                Console.WriteLine(cate.Id);  // Imprime cada valor en la consola
            }
            return Ok(categorias);
        }
    }
}

