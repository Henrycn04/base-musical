namespace backend.Models
{
    public class EjemplosMusicalesModel
    {
        public int Id { get; set; }            // Identificador único del ejemplo musical
        public string Nombre { get; set; }     // Nombre descriptivo del ejemplo
        public string Archivo { get; set; }     // Ruta al archivo del ejemplo musical
    }
}
