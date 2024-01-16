using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace RemindMe.Emailing.DataAccess.Migrations
{
    public partial class UpdatePropertyNamesInEmailingUserActivity : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Dates",
                table: "EmailingUserActivity",
                newName: "UtcDates");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "UtcDates",
                table: "EmailingUserActivity",
                newName: "Dates");
        }
    }
}
