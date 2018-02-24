using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace webDepartanetv1
{
    public partial class cargaPagos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargaMensualidades();
            }
        }

        protected void cargaMensualidades()
        {
            dbDepartanetEntities db = new dbDepartanetEntities();

            var prodcts = db.Productos.OrderBy(o => o.Periodo).ThenBy(m => m.Descripcion).ToList();

            ddlCatalogoMensualidad.Items.Clear();
            foreach (var item in prodcts)
            {
                ddlCatalogoMensualidad.Items.Add(new ListItem(item.Descripcion + " " + item.Periodo + ": " + item.Importe, item.id.ToString()));
            }


        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            comprobantesPago nwComprobante = new comprobantesPago();
            String idUsuario = User.Identity.GetUserId();

            if (FileUpload1.HasFile)
            {
                nwComprobante.id_producto = Int32.Parse(ddlCatalogoMensualidad.SelectedValue);
                nwComprobante.descripcion = txtDescripcion.Text;
                nwComprobante.id_usuario = idUsuario;
                nwComprobante.observaciones = "";
                nwComprobante.nom_archivo = idUsuario + "_" + FileUpload1.FileName;
                nwComprobante.fecha_alta = DateTime.Now;
                dbDepartanetEntities db = new dbDepartanetEntities();
                db.comprobantesPago.Add(nwComprobante);
                db.SaveChanges();

                // Specify the path to save the uploaded file to.
                string savePath = Server.MapPath("Archivos") + "\\" + nwComprobante.nom_archivo;
                FileUpload1.SaveAs(savePath);
            }

        }
    }
}