﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace webDepartanetv1
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class dbDepartanetEntities : DbContext
    {
        public dbDepartanetEntities()
            : base("name=dbDepartanetEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<C__MigrationHistory> C__MigrationHistory { get; set; }
        public virtual DbSet<AspNetRoles> AspNetRoles { get; set; }
        public virtual DbSet<AspNetUserClaims> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogins> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUsers> AspNetUsers { get; set; }
        public virtual DbSet<Productos> Productos { get; set; }
        public virtual DbSet<comprobantesPago> comprobantesPago { get; set; }
        public virtual DbSet<tbl_fichadepartamento> tbl_fichadepartamento { get; set; }
        public virtual DbSet<tbl_inquilinos> tbl_inquilinos { get; set; }
        public virtual DbSet<rel_inquilinodepto> rel_inquilinodepto { get; set; }
    }
}
