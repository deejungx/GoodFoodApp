using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace DataAccessLibrary.Models
{
    public class MenuItemModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Rate")]
        public decimal Rate { get; set; }

        [DisplayName("Name")]
        public string DisplayName { get; set; }

        [DisplayName("Diet Category")]
        public string DietCategory { get; set; }

        [DisplayName("Description")]
        public string Description { get; set; }

        [DisplayName("Availability")]
        public string IsAvailable { get; set; }

        public RestaurantModel Restaurant { get; set; }
        public DishModel Dish { get; set; }

        public int RestaurantId { get; set; }
        public int DishId { get; set; }

    }
}