using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace GoodFood.Models
{
    public class DisplayCuisineModel
    {
        [Required]
        [StringLength(15, ErrorMessage = "Name is too long.")]
        [MinLength(4, ErrorMessage = "Name is too short.")]
        public string Name { get; set; }

        [Required]
        [StringLength(255, ErrorMessage = "Description is too long.")]
        [MinLength(10, ErrorMessage = "Description is too short.")]
        public string Description { get; set; }
    }
}
