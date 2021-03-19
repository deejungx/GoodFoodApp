using System.ComponentModel;

namespace DataAccessLibrary.Models
{
    public class LineItemModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Quantity")]
        public int Quantity { get; set; }

        [DisplayName("Total")]
        public decimal ItemTotal { get; set; }

        [DisplayName("Order")]
        public OrderModel Order { get; set; }

        [DisplayName("Menu Item Id")]
        public int MenuItemId { get; set; }

        [DisplayName("Item")]
        public MenuItemModel MenuItem { get; set; }
    }
}
