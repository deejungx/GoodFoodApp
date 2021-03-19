using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccessLibrary.Models
{
    public class UserAddressModel
    {
        public int Id { get; set; }
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
        public string City { get; set; }
        public string Street { get; set; }
        public string Landmarks { get; set; }
        public CustomerModel User { get; set; }
        public int UserId { get; set; }
    }
}
