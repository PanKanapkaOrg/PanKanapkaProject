using Api.Domain.Components;
using Db.Contracts;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Swashbuckle.AspNetCore.Swagger;
using System.Data;
using System.Data.SqlClient;

namespace Api.Web
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddCors((options) => options.AddPolicy("AllowAllOrigins",
                builder =>
                {
                    builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
                }));
            services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1);
            services.AddScoped<IDbConnection>(p=>new SqlConnection(@"Integrated Security = SSPI; Persist Security Info = False; Initial Catalog = PanKanapka; Data Source =.\SQLEXPRESS;"));
            services.AddScoped<IWorkersRepository, WorkersDbRepository>();
            services.AddScoped<IReservationsRepository, ReservationsDbRepository>();
            services.AddScoped<IFoodsRepository, FoodsDbRepository>();
            services.AddScoped<IClientFirmsRepository, ClientFirmsDbRepository>();
            services.AddScoped<ITasksRepository, TasksDbRepository>();
            services.AddScoped<ILoginRepository, LoginDbRepository>();
            services.AddScoped<INotificationManager, NotificationManager>();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new Info { Title = "PanKanapka API", Description = "PanKanapka API" });

                var xmlPath = System.AppDomain.CurrentDomain.BaseDirectory + @"Api.Web.xml";
                c.IncludeXmlComments(xmlPath);
            }

            );
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseCors("AllowAllOrigins");
            app.UseMiddleware(typeof(ErrorHandlingMiddleware));
            app.UseMvc();

            app.UseSwagger();
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json","PanKanapka API");
            });
        }
    }
}
