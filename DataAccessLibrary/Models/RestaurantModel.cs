using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace DataAccessLibrary.Models
{
    public class RestaurantModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Name")]
        public string Name { get; set; }

        [DisplayName("Branch")]
        public string Branch { get; set; }

        [DisplayName("Bio")]
        public string Bio { get; set; }

        [DisplayName("Phone")]
        [Phone]
        public long Phone { get; set; }

        [DisplayName("Logo")]
        public byte[] DisplayPhoto { get; set; }

        [DisplayName("Cost for 2")]
        public float CostForTwo { get; set; }

        [DisplayName("City")]
        public string City { get; set; }

        [DisplayName("Street")]
        public string Street { get; set; }

    }
}
