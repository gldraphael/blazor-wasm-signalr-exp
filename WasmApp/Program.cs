using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace WasmApp
{
    public static class Program
    {
        public static async Task Main(string[] args)
        {
            var builder = WebAssemblyHostBuilder.CreateDefault(args);
            builder.RootComponents.Add<App>("app");

            var baseUrl = builder.HostEnvironment.IsDevelopment() ? "http://localhost:5000" : builder.HostEnvironment.BaseAddress; // TODO: Don't hardcode this
            builder.Services.AddTransient(sp => new HttpClient { BaseAddress = new Uri(baseUrl) });
            builder.Services.AddLogging();

            await builder.Build().RunAsync();
        }
    }
}
