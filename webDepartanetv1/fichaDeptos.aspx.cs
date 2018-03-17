using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
namespace webDepartanetv1
{
    public partial class fichaDeptos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargaFichaDepartamentos();
            }
            else
            {

            }
        }

        protected void cargaFichaDepartamentos()
        {
            dbDepartanetEntities db = new dbDepartanetEntities();

            gvFichasDepartamentos.DataBind();

            string idUsr = User.Identity.GetUserId();

            if (User.IsInRole("Administrador"))
            {
                gvFichasDepartamentos.DataSource = db.tbl_fichadepartamento.ToList();
            }
            else
            {
                gvFichasDepartamentos.Columns[0].Visible = false;
                gvFichasDepartamentos.DataSource = db.tbl_fichadepartamento.Where(d => d.rel_inquilinodepto.Where(rel => rel.tbl_inquilinos.rel_usr_inquilino.Where(inq => inq.id_usuario == idUsr).Count() > 0).Count() > 0).ToList();
            }
            gvFichasDepartamentos.DataBind();

        }

        protected void gvFichasDepartamentos_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvFichasDepartamentos.SelectedIndex = e.NewEditIndex;
            gvFichasDepartamentos_SelectedIndexChanged(sender, e);

            dbDepartanetEntities db = new dbDepartanetEntities();
            tbl_fichadepartamento ficha = db.tbl_fichadepartamento.Where(a => a.id == (int)gvFichasDepartamentos.SelectedDataKey.Value).First();

            txtNumero.Text = ficha.numero;
            txtEdificio.Text = ficha.edificio;
            txtObservaciones.Text = ficha.observaciones;


            ddlResponsable.Items.Clear();
            foreach (tbl_inquilinos item in db.tbl_inquilinos.ToList())
            {
                ddlResponsable.Items.Add(new ListItem(item.appaterno + " " + item.apmaterno + ", " + item.nombre, item.id.ToString()));
            }
            ddlResponsable.Items.Insert(0, new ListItem("...", ""));


            ddlDuenio.Items.Clear();
            foreach (tbl_inquilinos item in db.tbl_inquilinos.ToList())
            {
                ddlDuenio.Items.Add(new ListItem(item.appaterno + " " + item.apmaterno + ", " + item.nombre, item.id.ToString()));
            }
            ddlDuenio.Items.Insert(0, new ListItem("...", ""));


            if (db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == (int)gvFichasDepartamentos.SelectedDataKey.Value).Count() > 0 && a.tipo_inquilino == 1).Count() > 0)
            {
                ddlDuenio.SelectedValue = db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == (int)gvFichasDepartamentos.SelectedDataKey.Value).Count() > 0 && a.tipo_inquilino == 1).First().id.ToString();
            }

            if (db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == (int)gvFichasDepartamentos.SelectedDataKey.Value).Count() > 0 && a.tipo_inquilino == 2).Count() > 0)
            {
                ddlResponsable.SelectedValue = db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == (int)gvFichasDepartamentos.SelectedDataKey.Value).Count() > 0 && a.tipo_inquilino == 2).First().id.ToString();
            }

            btnGuardar.Visible = false;
            btnActualizar.Visible = true;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
        }


        protected void btnSelect_Click(object sender, EventArgs e)
        {
            //gvFichasDepartamentos.SelectedIndex = ((GridViewRow)((Button)sender).Parent.Parent).RowIndex;
            //gvFichasDepartamentos_SelectedIndexChanged(sender, e);
            ////actualizar comprobate de pago
            //dbDepartanetEntities db = new dbDepartanetEntities();
            //int indice = gvFichasDepartamentos.SelectedIndex;
            //int pago = Int32.Parse(gvFichasDepartamentos.SelectedDataKey["id"].ToString());

            //comprobantesPago nwComp = db.comprobantesPago.Where(a => a.id == pago).First();
            //nwComp.observaciones = ((TextBox)gvFichasDepartamentos.SelectedRow.FindControl("txtObservaciones")).Text;
            //nwComp.fecha_validado = DateTime.Now;
            //db.SaveChanges();
            //cargaFichaDepartamentos();
        }

        protected void gvFichasDepartamentos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gvFichasDepartamentos_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            gvFichasDepartamentos.SelectedIndex = e.NewSelectedIndex;
        }

        protected string construyeUbicacion(int id)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();

            tbl_fichadepartamento Depto = db.tbl_fichadepartamento.Where(a => a.id == id).First();

            return ("Número: " + Depto.numero + "<br>" + "Edificio: " + Depto.edificio).ToString();
        }

        protected string ObtenOcupantes(int id, string tipo)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();

            System.Text.StringBuilder str = new System.Text.StringBuilder();

            if (tipo == "dueño")
            {
                foreach (tbl_inquilinos item in db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == id).Count() > 0 && a.tipo_inquilino == 1))
                {
                    str.AppendLine(item.appaterno + " " + item.apmaterno + ", " + item.nombre + "<br>");
                    str.AppendLine("Tel cel: " + item.tel_cel + "<br>Tel casa: " + item.tel_casa + "<br>");
                    str.AppendLine("email: " + item.correo);
                }
            }
            else if (tipo == "responsable")
            {
                foreach (tbl_inquilinos item in db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == id).Count() > 0 && a.tipo_inquilino == 2))
                {
                    str.AppendLine(item.appaterno + " " + item.apmaterno + ", " + item.nombre + "<br>");
                    str.AppendLine("Tel cel: " + item.tel_cel + "<br>Tel casa: " + item.tel_casa + "<br>");
                    str.AppendLine("email: " + item.correo);
                }
            }
            else if (tipo == "inquilino")
            {
                foreach (tbl_inquilinos item in db.tbl_inquilinos.Where(a => a.rel_inquilinodepto.Where(b => b.id_fichadepto == id).Count() > 0 && a.tipo_inquilino == 3))
                {
                    str.AppendLine(item.appaterno + " " + item.apmaterno + ", " + item.nombre + "<br>");
                    str.AppendLine("Tel cel: " + item.tel_cel + "<br>Tel casa: " + item.tel_casa + "<br>");
                    str.AppendLine("email: " + item.correo);
                }
            }


            return str.ToString();
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();

            txtNumero.Text = "";
            txtEdificio.Text = "";
            txtObservaciones.Text = "";


            ddlResponsable.Items.Clear();
            foreach (tbl_inquilinos item in db.tbl_inquilinos.ToList())
            {
                ddlResponsable.Items.Add(new ListItem(item.appaterno + " " + item.apmaterno + ", " + item.nombre, item.id.ToString()));
            }
            ddlResponsable.Items.Insert(0, new ListItem("...", ""));


            ddlDuenio.Items.Clear();
            foreach (tbl_inquilinos item in db.tbl_inquilinos.ToList())
            {
                ddlDuenio.Items.Add(new ListItem(item.appaterno + " " + item.apmaterno + ", " + item.nombre, item.id.ToString()));
            }
            ddlDuenio.Items.Insert(0, new ListItem("...", ""));

            btnGuardar.Visible = true;
            btnActualizar.Visible = false;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            dbDepartanetEntities db = new dbDepartanetEntities();
            tbl_fichadepartamento nwFicha = new tbl_fichadepartamento();

            nwFicha.numero = txtNumero.Text;
            nwFicha.edificio = txtEdificio.Text;
            nwFicha.observaciones = txtObservaciones.Text;
            nwFicha.estatus = 1;


            db.tbl_fichadepartamento.Add(nwFicha);
            db.SaveChanges();


            rel_inquilinodepto newREl = new rel_inquilinodepto();
            newREl.id_fichadepto = nwFicha.id;
            newREl.id_inquilino = int.Parse(ddlDuenio.SelectedValue.ToString());
            newREl.tipo_inquilino = 1;

            db.rel_inquilinodepto.Add(newREl);


            rel_inquilinodepto newREl2 = new rel_inquilinodepto();
            newREl2.id_fichadepto = nwFicha.id;
            newREl2.id_inquilino = int.Parse(ddlResponsable.SelectedValue.ToString());
            newREl2.tipo_inquilino = 2;

            db.rel_inquilinodepto.Add(newREl2);

            db.SaveChanges();
            cargaFichaDepartamentos();
        }
    }
}