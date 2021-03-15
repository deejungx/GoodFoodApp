using System.ComponentModel;

namespace DataAccessLibrary.Models
{
    public class DishModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Code")]
        public string Code { get; set; }

        [DisplayName("Name")]
        public string Name { get; set; }
    }
}
