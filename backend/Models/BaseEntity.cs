﻿namespace backend.Models
{
    public abstract class BaseEntity
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public DateTime UpdatedAt { get; set; } = DateTime.Now;

        public void UpdateTimestamp()
        {
            UpdatedAt = DateTime.Now;
        }
    }
}
