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
    public partial class InformeProductos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                llenarDdlProductos();
            }
        }

        public void llenarDdlProductos()
        {
            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPlistarProductos";
            SqlDataAdapter da = new SqlDataAdapter(comando);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddlProductos.DataSource = ds;
            ddlProductos.DataValueField = "codigoProducto";
            ddlProductos.DataTextField = "texto";
            ddlProductos.DataBind();
            ddlProductos.Items.Insert(0, new ListItem("-- Seleccione el Producto --", ""));
            ddlProductos.Items[0].Attributes["selected"] = "selected";
            ddlProductos.Items[0].Attributes["disabled"] = "disabled";
            ConnectionDB.Close();
        }

        protected void btnFiltrarProductos_Click(object sender, EventArgs e)
        {
            string fi = startDate.Text;
            string ff = endDate.Text;
            string ps = ddlProductos.SelectedValue;

            if (String.IsNullOrEmpty(fi) && !(String.IsNullOrEmpty(ps)))
            {
                SqlCommand comando = new SqlCommand("SELECT producto, SUM(cantidadPedida) AS CantidadP, SUM(cantidadRecibida) AS CantidadR, (SUM(precio) / SUM(cantidadPedida)) AS PrecioP, SUM(precio) AS PrecioT FROM ProductoXOrden GROUP BY producto HAVING producto = @ps", ConnectionDB.Open());
                comando.Parameters.AddWithValue("@ps", Convert.ToInt32(ps));

                SqlCommand comandoprod = new SqlCommand("SELECT numero, fechaEntrega, nit, nombreProveedor FROM (SELECT * FROM Orden WHERE estado = 3) O INNER JOIN ( SELECT * FROM ProductoXOrden WHERE producto = 1) PO ON O.numero = PO.orden INNER JOIN Proveedor P ON P.nit = O.proveedor WHERE producto = @ps", ConnectionDB.Open());
                comandoprod.Parameters.AddWithValue("@ps", Convert.ToInt32(ps));

                SqlDataAdapter da = new SqlDataAdapter(comando);
                SqlDataAdapter daprod = new SqlDataAdapter(comandoprod);
                DataTable dt = new DataTable();
                DataTable dtdaprod = new DataTable();
                da.Fill(dt);
                daprod.Fill(dtdaprod);
                gvInformeOrden.DataSource = dt;
                gvInfo.DataSource = dtdaprod;
                gvInformeOrden.DataBind();
                gvInfo.DataBind();
                ConnectionDB.Close();
            }
        }
    }
}