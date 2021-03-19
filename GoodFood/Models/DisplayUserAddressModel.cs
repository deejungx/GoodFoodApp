using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FluentValidation;

namespace GoodFood.Models
{
    public class DisplayUserAddressModel
    {
        public decimal Longitude { get; set; }
        public decimal Latitude { get; set; }
        public string City { get; set; }
        public string Street { get; set; }
        public string Landmarks { get; set; }
    }

    public class UserAddressValidator : AbstractValidator<DisplayUserAddressModel>
    {
        public UserAddressValidator()
        {
            RuleFor(userAddress => userAddress.Longitude).NotEmpty();
            RuleFor(userAddress => userAddress.Latitude).NotEmpty();
            RuleFor(userAddress => userAddress.City).NotEmpty().MaximumLength(100);
            RuleFor(userAddress => userAddress.Street).NotEmpty().MaximumLength(255);
            RuleFor(userAddress => userAddress.Landmarks).MaximumLength(255);
        }
    }
}
