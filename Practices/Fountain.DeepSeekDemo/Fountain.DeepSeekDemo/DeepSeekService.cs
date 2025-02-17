using Fountain.DeepSeekDemo.Models;
using Microsoft.Extensions.Configuration;
using RestSharp;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Encodings.Web;
using System.Text.Json;

namespace Fountain.DeepSeekDemo
{
    public class DeepSeekService
    {
        private readonly RestClient restClient;
        /// <summary>
        /// 
        /// </summary>
        private readonly string deepSeekAPIKey;
        private IConfiguration _Configuration;
        private readonly HttpClient httpClient;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="configuration"></param>
        public DeepSeekService(IConfiguration configuration)
        {
            _Configuration = configuration;
            httpClient = new HttpClient();
            deepSeekAPIKey = configuration["DEEPSEEK_API_KEY"] ?? "";
            restClient = new RestClient(configuration["DEEPSEEK_BASE_URL"] ?? "");
            restClient.AddDefaultHeader("Authorization", $"Bearer {deepSeekAPIKey}");
            restClient.AddDefaultHeader("Content-Type", "application/json");
            // 添加 API Key 到请求头
            httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {deepSeekAPIKey}");
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="userMessage"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public async Task<string> SendMessageAsync(string userMessage)
        {

            string systemPrompt = @"你的AI助手";
            // 
            var deepSeekRequest = new DeepSeekRequest
            {
                Messages = new List<DeepSeekMessage>
                {
                    new DeepSeekMessage { Role = "system", Content = systemPrompt },
                    new DeepSeekMessage { Role = "user", Content = userMessage }
                }
            };
            // 配置 JsonSerializer 使用的选项 此处配置支持中文不转义
            var options = new JsonSerializerOptions
            {
                // 允许字符通过而不进行转义方面更加宽松
                Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping,
                // 反序列化不区分大小写
                PropertyNameCaseInsensitive = true,
                // 驼峰命名
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };
            // 将对象序列化为JSON
            string json = JsonSerializer.Serialize(deepSeekRequest, options);

            var content = new StringContent(json, Encoding.UTF8, "application/json");


            var response = await httpClient.PostAsync(_Configuration["DEEPSEEK_BASE_URL"] ?? "", content);

            if (response.IsSuccessStatusCode)
            {
                var responseJson = await response.Content.ReadAsStringAsync();
                DeepSeekResponse deepSeekResponse = JsonSerializer.Deserialize<DeepSeekResponse>(responseJson, options);
                return deepSeekResponse.Choices?.FirstOrDefault()?.Message?.Content ?? "DeepSeek没有回应。";
            }
            else
            {
                throw new Exception($"请求失败，状态码: {response.StatusCode}");
            }




            //var request = new RestRequest
            //{
            //    Method = Method.Post
            //};


            //request.AddJsonBody(deepSeekRequest);
            //// 调用API
            //var response = await restClient.ExecuteAsync<DeepSeekResponse>(request);

            //if (!response.IsSuccessful)
            //{
            //    throw new Exception($"异常: {response.StatusCode} - {response.ErrorMessage}");
            //}
            //// 返回响应
            //return response.Data?.Choices?.FirstOrDefault()?.Message?.Content ?? "DeepSeek没有回应。";

        }
    }
}
