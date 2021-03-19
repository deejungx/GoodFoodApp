using FluentValidation;
using DataAccessLibrary.Models;

namespace GoodFood.Models
{
    public class DisplayMenuItemModel
    {

        public decimal Rate { get; set; }

        public string DisplayName { get; set; }

        public string DietCategory { get; set; }

        public string Description { get; set; }

        public bool IsAvailable { get; set; }
    }

    public class MenuItemValidator : AbstractValidator<DisplayMenuItemModel>
    {
        public MenuItemValidator()
        {
            RuleFor(menuitem => menuitem.Rate).NotEmpty();
            RuleFor(menuitem => menuitem.DisplayName).NotEmpty();
            RuleFor(menuitem => menuitem.DietCategory).NotEmpty();
            RuleFor(menuitem => menuitem.Description).NotEmpty();
            RuleFor(menuitem => menuitem.IsAvailable).NotEmpty();
        }
    }
}
