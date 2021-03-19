using System;
using FluentValidation;

namespace GoodFood.Models
{
    public class DisplayLoyaltyPointModel
    {
        public decimal Points { get; set; }

        public string Status { get; set; }

        public DateTime ActiveFrom { get; set; }

        public DateTime ActiveUntil { get; set; }

    }

    public class LoyaltyPointValidator : AbstractValidator<DisplayLoyaltyPointModel>
    {
        public LoyaltyPointValidator()
        {
            RuleFor(loyaltyPoint => loyaltyPoint.Points).NotEmpty();
            RuleFor(loyaltyPoint => loyaltyPoint.Status).NotEmpty();
            RuleFor(loyaltyPoint => loyaltyPoint.ActiveFrom).NotEmpty();
            RuleFor(loyaltyPoint => loyaltyPoint.ActiveUntil).NotEmpty();
        }
    }
}
