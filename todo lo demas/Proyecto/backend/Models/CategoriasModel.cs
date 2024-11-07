namespace backend.Models
{
    public class CategoriasModel
    {
        public int Id { get; set; }            // Identificador único de la categoría
        public string Nombre { get; set; }     // Nombre de la categoría
        public int? PadreId { get; set; }      // ID del padre para subcategorías (nullable)
    }
}
