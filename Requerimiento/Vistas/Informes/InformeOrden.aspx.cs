using Requerimiento.Connection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Requerimiento.Vistas.Informes
{
    public partial class InformeOrden : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnFiltrarOrden_Click(object sender, EventArgs e)
        {
            string fi = startDate.Text;
            string ff = endDate.Text;
            string os = orderStatus.SelectedValue;

            if (String.IsNullOrEmpty(fi) && !(String.IsNullOrEmpty(os)))
            {
                SqlCommand comando = new SqlCommand("SELECT orden, fechaOrden, nit, nombreProveedor, fechaEntrega, PrecioTotal, estado FROM Orden O INNER JOIN (SELECT orden, SUM(precio) AS PrecioTotal FROM ProductoXOrden GROUP BY orden) PO ON PO.orden = O.numero INNER JOIN Proveedor P ON P.nit = O.proveedor WHERE estado = @os ORDER BY orden", ConnectionDB.Open());
                comando.Parameters.AddWithValue("@os", Convert.ToInt32(os));

                SqlDataAdapter da = new SqlDataAdapter(comando);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvInformeOrden.DataSource = dt;
                gvInformeOrden.DataBind();
                ConnectionDB.Close();
            }

            if (!String.IsNullOrEmpty(fi) && (String.IsNullOrEmpty(os)))
            {
                SqlCommand comando = new SqlCommand("SELECT orden, fechaOrden, nit, nombreProveedor, fechaEntrega, PrecioTotal, estado FROM Orden O INNER JOIN (SELECT orden, SUM(precio) AS PrecioTotal FROM ProductoXOrden GROUP BY orden) PO ON PO.orden = O.numero INNER JOIN Proveedor P ON P.nit = O.proveedor WHERE fechaOrden BETWEEN @fi AND @ff ORDER BY fechaOrden", ConnectionDB.Open());
                comando.Parameters.AddWithValue("@fi", Convert.ToDateTime(fi));
                comando.Parameters.AddWithValue("@ff", Convert.ToDateTime(ff));

                SqlDataAdapter da = new SqlDataAdapter(comando);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvInformeOrden.DataSource = dt;
                gvInformeOrden.DataBind();
                ConnectionDB.Close();
            }

            if (!String.IsNullOrEmpty(fi) && (!String.IsNullOrEmpty(os)))
            {
                SqlCommand comando = new SqlCommand("SELECT orden, fechaOrden, nit, nombreProveedor, fechaEntrega, PrecioTotal, estado FROM Orden O INNER JOIN (SELECT orden, SUM(precio) AS PrecioTotal FROM ProductoXOrden GROUP BY orden) PO ON PO.orden = O.numero INNER JOIN Proveedor P ON P.nit = O.proveedor WHERE estado = @os AND fechaOrden BETWEEN @fi AND @ff ORDER BY fechaOrden", ConnectionDB.Open());
                comando.Parameters.AddWithValue("@os", Convert.ToInt32(os));
                comando.Parameters.AddWithValue("@fi", Convert.ToDateTime(fi));
                comando.Parameters.AddWithValue("@ff", Convert.ToDateTime(ff));

                SqlDataAdapter da = new SqlDataAdapter(comando);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvInformeOrden.DataSource = dt;
                gvInformeOrden.DataBind();
                ConnectionDB.Close();
            }
        }
    }
}