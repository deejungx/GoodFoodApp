using FluentValidation;

namespace GoodFood.Models
{
    public class DisplayRestaurantModel
    {
        public string Name { get; set; }
        public string Branch { get; set; }
        public string Bio { get; set; }
        public long Phone { get; set; }
        public byte[] DisplayPhoto { get; set; }
        public decimal CostForTwo { get; set; }
        public string City { get; set; }
        public string Street { get; set; }
    }

    public class RestaurantValidator : AbstractValidator<DisplayRestaurantModel>
    {
        public RestaurantValidator()
        {
            RuleFor(restaurant => restaurant.Name).NotEmpty().MaximumLength(100);
            RuleFor(restaurant => restaurant.Branch).NotEmpty().MaximumLength(100);
            RuleFor(restaurant => restaurant.Bio).NotEmpty().MaximumLength(255);
            RuleFor(restaurant => restaurant.Phone).NotEmpty();
            RuleFor(restaurant => restaurant.CostForTwo).NotEmpty();
            RuleFor(restaurant => restaurant.City).NotEmpty().MaximumLength(100);
            RuleFor(restaurant => restaurant.Street).MaximumLength(255);
        }
    }
}
