using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webDepartanetv1
{
    public partial class fichaInquilino : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                cargaFichaInquilinos();
            }
            else
            {

            }
        }

        protected void cargaFichaInquilinos()
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            gvFichaInquilinos.DataSource = db.tbl_inquilinos.ToList();
            gvFichaInquilinos.DataBind();
        }

        protected void gvFichaInquilinos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFichaInquilinos.SelectedIndex = e.NewEditIndex;
            gvFichaInquilinos_SelectedIndexChanged(sender, e);

            dbDepartanetEntities db = new dbDepartanetEntities();
            tbl_inquilinos ficha = db.tbl_inquilinos.Where(a => a.id == (int)gvFichaInquilinos.SelectedDataKey.Value).First();

            txtAppaterno.Text = ficha.appaterno;
            txtApmaterno.Text = ficha.apmaterno;
            txtNombre.Text = ficha.nombre;
            txtTelcel.Text = ficha.tel_cel;
            txtTelCasa.Text = ficha.tel_casa;
            txtEmail.Text = ficha.correo;
            rblTipo.SelectedValue = ficha.tipo_inquilino.ToString();
            btnActualizar.Visible = true;
            btnGuardar.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
        }


        protected void btnSelect_Click(object sender, EventArgs e)
        {
            //gvFichaInquilinos.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            //gvFichaInquilinos_SelectedIndexChanged(sender, e);
            ////actualizar comprobate de pago
            //dbDepartanetEntities db = new dbDepartanetEntities();
            //int indice = gvFichaInquilinos.SelectedIndex;
            //int pago = Int32.Parse(gvFichaInquilinos.SelectedDataKey["id"].ToString());

            //comprobantesPago nwComp = db.comprobantesPago.Where(a => a.id == pago).First();
            //nwComp.observaciones = ((TextBox)gvFichaInquilinos.SelectedRow.FindControl("txtObservaciones")).Text;
            //nwComp.fecha_validado = DateTime.Now;
            //db.SaveChanges();
            //cargaFichaDepartamentos();
        }

        protected void gvFichaInquilinos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvFichaInquilinos_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            gvFichaInquilinos.SelectedIndex = e.NewSelectedIndex;
        }

        public string TipoInquilino(int tipo_inquilino)
        {
            string nom_tipo_inquilino = "";

            switch (tipo_inquilino)
            {
                case 1:
                    nom_tipo_inquilino = "Dueño";
                    break;
                case 2:
                    nom_tipo_inquilino = "Responsable";
                    break;
                default:
                    nom_tipo_inquilino = "Inquilino";
                    break;
            }
            return nom_tipo_inquilino;

        }



        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();


            txtAppaterno.Text = "";
            txtApmaterno.Text = "";
            txtNombre.Text = "";
            txtTelcel.Text = "";
            txtTelCasa.Text = "";
            txtEmail.Text = "";
            rblTipo.ClearSelection();
            btnActualizar.Visible = false;
            btnGuardar.Visible = true;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);

        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            tbl_inquilinos edFicha = db.tbl_inquilinos.Where(a => a.id == (int)gvFichaInquilinos.SelectedDataKey.Value).First();

            edFicha.appaterno = txtAppaterno.Text;
            edFicha.apmaterno = txtApmaterno.Text;
            edFicha.nombre = txtNombre.Text;
            edFicha.tel_cel = txtTelcel.Text;
            edFicha.tel_casa = txtTelCasa.Text;
            edFicha.correo = txtEmail.Text;
            edFicha.tipo_inquilino = int.Parse(rblTipo.SelectedValue.ToString());
            db.Entry(edFicha).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            cargaFichaInquilinos();

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            tbl_inquilinos nwFicha = new tbl_inquilinos();

            nwFicha.appaterno = txtAppaterno.Text;
            nwFicha.apmaterno = txtApmaterno.Text;
            nwFicha.nombre = txtNombre.Text;
            nwFicha.tel_cel = txtTelcel.Text;
            nwFicha.tel_casa = txtTelCasa.Text;
            nwFicha.correo = txtEmail.Text;
            nwFicha.tipo_inquilino = int.Parse(rblTipo.SelectedValue.ToString());
            db.tbl_inquilinos.Add(nwFicha);
            db.SaveChanges();
            cargaFichaInquilinos();

        }
    }
}