using Requerimiento.Connection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Requerimiento.Vistas.Orden
{
    public partial class ListarPendientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnFiltro_Click(object sender, EventArgs e)
        {
            //gvPendientes
            DateTime filtroFecha = Convert.ToDateTime(txtfiltroFecha.Text);

            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPordenesPendientes";
            comando.Parameters.AddWithValue("@fecha", filtroFecha);
            SqlDataAdapter da = new SqlDataAdapter(comando);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvPendientes.DataSource = dt;
            gvPendientes.DataBind();
            ConnectionDB.Close();
        }

        [WebMethod]
        public static HttpStatusCodeResult cancelarOrden(string Orden)
        {
            bool nonquery = Cancelar(Orden);

            if (nonquery == true)
            {
                return new HttpStatusCodeResult(200, "Orden cancelada correctamente!");
            }
            else
            {
                return new HttpStatusCodeResult(400, "Hubo un problema con la solicitud!");
            }
        }

        public static bool Cancelar(string Orden)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.Connection = ConnectionDB.Open();
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandText = "SPcancelarOrden";
                comando.Parameters.AddWithValue("@numero", Convert.ToInt32(Orden));
                bool proc = Convert.ToBoolean(comando.ExecuteNonQuery());
                if (proc)
                {
                    ConnectionDB.Close();
                    return true;
                }
                ConnectionDB.Close();
                return false;
            }
            catch (Exception)
            {
                ConnectionDB.Close();
                return false;
            }
        }

        protected void gvPendientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Recibir")
            {
                Response.Redirect("~/Vistas/Orden/RecibirOrden.aspx?numero=" + e.CommandArgument);
            }
        }
    }
}