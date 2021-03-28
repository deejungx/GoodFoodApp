using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace DataAccessLibrary.Models
{
    public class OrderModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Serial Number")]
        public int SerialNumber { get; set; }

        [DisplayName("Order Total")]
        public decimal OrderTotal { get; set; }

        [DisplayName("Order Status")]
        public string OrderStatus { get; set; }

        [DisplayName("Payment Status")]
        public string PaymentStatus { get; set; }

        [DisplayName("Creation Date")]
        public DateTime CreationDate { get; set; }

        [DisplayName("Loyalty Score")]
        public decimal LoyaltyScore { get; set; }

        [DisplayName("User")]
        public CustomerModel User { get; set; }

        public List<LineItemModel> LineItems { get; set; }

    }
}
