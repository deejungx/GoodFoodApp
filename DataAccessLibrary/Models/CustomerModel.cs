using System.ComponentModel;

namespace DataAccessLibrary.Models
{
    public class CustomerModel
    {
        [DisplayName("Id")]
        public int Id { get; set; }

        [DisplayName("Username")]
        public string Username { get; set; }

        [DisplayName("Phone")]
        public long Phone { get; set; }

        [DisplayName("Email")]
        public string Email { get; set; }

        [DisplayName("Password")]
        public string Password { get; set; }

        [DisplayName("Redeemed Loyalty")]
        public int RedeemedLoyalty { get; set; }

        public UserAddressModel Address { get; set; }
    }
}
