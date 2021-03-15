using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace GoodFood.Models
{
    public class DisplayDishModel
    {
        [Required]
        [StringLength(6, ErrorMessage = "Code is too long.")]
        [MinLength(4, ErrorMessage = "Code is too short.")]
        public string Code { get; set; }

        [Required]
        [StringLength(255, ErrorMessage = "Name is too long.")]
        public string Name { get; set; }
    }
}
