using Microsoft.AspNetCore.Mvc;
using backend.Models;

namespace backend.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FlashcardController : Controller
    {
        public IActionResult Index()
        {
            Users user = new Users("Alex", "alex.doerr@live.com");

            
            return View();
        }
    }
}
