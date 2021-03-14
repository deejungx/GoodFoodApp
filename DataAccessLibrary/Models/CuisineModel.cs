using System.ComponentModel;

namespace DataAccessLibrary.Models
{
    public class CuisineModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Name")]
        public string Name { get; set; }

        [DisplayName("Description")]
        public string Description { get; set; }
    }
}
