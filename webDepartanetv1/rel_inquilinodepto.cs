//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class rel_inquilinodepto
    {
        public int id { get; set; }
        public int id_inquilino { get; set; }
        public int id_fichadepto { get; set; }
        public int tipo_inquilino { get; set; }
    
        public virtual tbl_fichadepartamento tbl_fichadepartamento { get; set; }
        public virtual tbl_inquilinos tbl_inquilinos { get; set; }
    }
}
