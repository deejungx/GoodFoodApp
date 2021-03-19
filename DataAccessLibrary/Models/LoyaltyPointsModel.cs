using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace DataAccessLibrary.Models
{
    public class LoyaltyPointsModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Points")]
        public decimal Points { get; set; }

        [DisplayName("Status")]
        public string Status { get; set; }

        [DisplayName("Active From")]
        public DateTime ActiveFrom { get; set; }

        [DisplayName("Active Until")]
        public DateTime ActiveUntil { get; set; }
        public MenuItemModel Menu { get; set; }
        public int MenuId { get; set; }
    }
}
