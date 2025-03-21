﻿namespace Fountain.DeepSeekDemo.Models
{
    public class DeepSeekResponse
    {
        public string Id { get; set; } = "";
        public string Object { get; set; } = "";
        public long Created { get; set; }
        public string Model { get; set; } = "";
        public List<DeepSeekChoice> Choices { get; set; }
    }
}
