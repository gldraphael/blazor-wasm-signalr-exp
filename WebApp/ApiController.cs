using Microsoft.AspNetCore.Mvc;

namespace WebApp
{
    [ApiController]
    public class ApiController : ControllerBase
    {
        [HttpGet("/api/ping")]
        public IActionResult Ping() => Ok("Pong");
    }
}
