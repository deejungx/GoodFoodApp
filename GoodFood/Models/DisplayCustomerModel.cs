using FluentValidation;

namespace GoodFood.Models
{
    public class DisplayCustomerModel
    {
        public string Username { get; set; }
        public long Phone { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public int RedeemedLoyalty { get; set; }
    }

    public class CustomerValidator : AbstractValidator<DisplayCustomerModel>
    {
        public CustomerValidator()
        {
            RuleFor(customer => customer.Username).NotEmpty().MaximumLength(50);
            RuleFor(customer => customer.Phone).NotEmpty();
            RuleFor(customer => customer.Email).NotEmpty();
            RuleFor(customer => customer.Password).NotEmpty();
        }
    }
}


    