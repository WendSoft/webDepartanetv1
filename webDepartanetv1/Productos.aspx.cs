using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webDepartanetv1
{
    public partial class Productos1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ddlPeriodo.SelectedValue = "2018";
            }
            else
            {

            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Productos nwProducto = new Productos();
            nwProducto.Nombre = txtNombre.Text;
            nwProducto.Descripcion = txtDescripcion.Text;
            nwProducto.Periodo = ddlPeriodo.SelectedValue;
            nwProducto.Activo = 1;
            nwProducto.vencimiento = Convert.ToDateTime(txtVencimiento.Text);
            nwProducto.Importe = decimal.Parse(txtImporte.Text);

            dbDepartanetEntities db = new dbDepartanetEntities();
            db.Productos.Add(nwProducto);
            db.SaveChanges();




        }
    }
}