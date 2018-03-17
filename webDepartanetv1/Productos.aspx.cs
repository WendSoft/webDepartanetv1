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
                llenarPeriodos();
                llenarConceptos();
            }
            else
            {

            }

        }

        protected void llenarPeriodos()
        {
            for (int i = 2018; i <= 2050; i++)
            {
                ddlPeriodo.Items.Add(new ListItem("Periodo " + i, i.ToString()));
            }

            ddlPeriodo.SelectedValue = DateTime.Now.Year.ToString();
        }

        protected void llenarConceptos()
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            gvProductos.DataSource = db.Productos.OrderBy(u => u.vencimiento).ToList();
            gvProductos.DataBind();

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            Productos nwProducto = new Productos();
            nwProducto.Nombre = txtNombre.Text;
            nwProducto.Descripcion = txtDescripcion.Text;
            nwProducto.Periodo = ddlPeriodo.SelectedValue;
            nwProducto.Activo = 1;
            nwProducto.vencimiento = DateTime.Parse(txtVencimiento.Text.Split('/')[0] + '/' + txtVencimiento.Text.Split('/')[1] + '/' + txtVencimiento.Text.Split('/')[2]);
            nwProducto.Importe = decimal.Parse(txtImporte.Text);

            dbDepartanetEntities db = new dbDepartanetEntities();
            db.Productos.Add(nwProducto);
            db.SaveChanges();

            llenarConceptos();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            ddlPeriodo.SelectedValue = DateTime.Now.Year.ToString();
            txtNombre.Text = "";
            txtDescripcion.Text = "";
            txtImporte.Text = "0";
            txtVencimiento.Text = DateTime.Now.ToShortDateString();
            llenarConceptos();
        }

        protected void gvProductos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvProductos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProductos.SelectedIndex = e.NewEditIndex;
            gvProductos_SelectedIndexChanged(sender, e);
            int prod = Int32.Parse(gvProductos.SelectedDataKey["id"].ToString());

            dbDepartanetEntities db = new dbDepartanetEntities();
            Productos nwProd = db.Productos.Where(a => a.id == prod).First();

            ddlPeriodo.SelectedValue = nwProd.Periodo;
            txtNombre.Text = nwProd.Nombre;
            txtDescripcion.Text = nwProd.Descripcion;
            txtImporte.Text = nwProd.Importe.ToString();
            txtVencimiento.Text = ((DateTime)nwProd.vencimiento).Day.ToString() + "/" + ((DateTime)nwProd.vencimiento).Month + "/" + ((DateTime)nwProd.vencimiento).Year.ToString();

            btnGuardar.Visible = false;
            btnActualizar.Visible = true;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
        }

        protected void gvProductos_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {

        }

        protected void gvProductos_PreRender(object sender, EventArgs e)
        {

        }

        protected void PageDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected string setDateTime(DateTime fecha)
        {
            return fecha.ToShortDateString();
        }

        protected void gvProductos_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            gvProductos.SelectedIndex = e.NewSelectedIndex;
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            gvProductos.SelectedIndex = -1;
            btnGuardar.Visible = true;
            btnActualizar.Visible = false;

            ddlPeriodo.ClearSelection();
            txtDescripcion.Text = "Descripción";
            txtImporte.Text = decimal.Parse("0.00").ToString();
            txtNombre.Text = "Nuevo Concepto";
            txtVencimiento.Text = DateTime.Now.Day.ToString() + '/' + DateTime.Now.Month.ToString() + '/' + DateTime.Now.Year.ToString();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            int prod = Int32.Parse(gvProductos.SelectedDataKey["id"].ToString());

            dbDepartanetEntities db = new dbDepartanetEntities();
            Productos edProd = db.Productos.Where(a => a.id == prod).First();

            edProd.Periodo = ddlPeriodo.SelectedValue;
            edProd.Nombre = txtNombre.Text;
            edProd.Descripcion = txtNombre.Text;
            edProd.Activo = 1;
            edProd.vencimiento = DateTime.Parse(txtVencimiento.Text.Split('/')[0] + '/' + txtVencimiento.Text.Split('/')[1] + '/' + txtVencimiento.Text.Split('/')[2]);
            edProd.Importe = decimal.Parse(txtImporte.Text);

            db.Entry(edProd).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            llenarConceptos();
        }
    }
}