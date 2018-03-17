using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace webDepartanetv1
{
    public partial class generalPagos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarComprobantes();
            }
            else
            {

            }
        }

        protected void CargarComprobantes()
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            string idUsr = User.Identity.GetUserId();

            if (User.IsInRole("Administrador"))
            {
                gvComprobantes.DataSource = db.comprobantesPago.ToList();
            }
            else
            {
                gvComprobantes.Columns[0].Visible = false;
                gvComprobantes.Columns[gvComprobantes.Columns.Count - 1].Visible = false;
                gvComprobantes.DataSource = db.comprobantesPago.Where(u => u.id_usuario == idUsr).ToList();
            }


            gvComprobantes.DataBind();
        }

        protected string ObtenUsuario(string id_usuario)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();

            return db.AspNetUsers.Where(u => u.Id == id_usuario).First().UserName.ToString();


        }


        protected string ObtenProducto(int id_producto)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            Productos product = db.Productos.Where(u => u.id == id_producto).First();
            return product.Nombre.ToString() + "\r\n Vencimiento:" + product.vencimiento.Value.ToShortDateString();
        }

        protected void btnSelect_Click(object sender, EventArgs e)
        {
            gvComprobantes.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            gvComprobantes_SelectedIndexChanged(sender, e);
            //actualizar comprobate de pago
            dbDepartanetEntities db = new dbDepartanetEntities();
            int indice = gvComprobantes.SelectedIndex;
            int pago = Int32.Parse(gvComprobantes.SelectedDataKey["id"].ToString());

            comprobantesPago nwComp = db.comprobantesPago.Where(a => a.id == pago).First();
            nwComp.observaciones = ((TextBox)gvComprobantes.SelectedRow.FindControl("txtObservaciones")).Text;
            nwComp.fecha_validado = DateTime.Now;
            db.SaveChanges();
            CargarComprobantes();
        }

        protected void gvComprobantes_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvComprobantes_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            gvComprobantes.SelectedIndex = e.NewSelectedIndex;
        }
    }
}