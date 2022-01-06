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
    public partial class RecibirOrden : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                llenarEncabezado();
                llenarDetalle();
            }
        }

        public void llenarEncabezado()
        {
            int orden = int.Parse(Request.QueryString["numero"]);
            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPordenPorID";
            comando.Parameters.AddWithValue("@orden", orden);
            SqlDataAdapter da = new SqlDataAdapter(comando);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ConnectionDB.Close();
            txtNumero.Text = dt.Rows[0]["numero"].ToString();
            txtFechaOrden.Text = dt.Rows[0]["fechaOrden"].ToString();
            txtProveedor.Text = dt.Rows[0]["Proveedor"].ToString();
            txtFechaEstimada.Text = dt.Rows[0]["fechaEntrega"].ToString();
        }

        public void llenarDetalle()
        {
            int orden = int.Parse(Request.QueryString["numero"]);
            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPdetallePorID";
            comando.Parameters.AddWithValue("@orden", orden);
            SqlDataAdapter da = new SqlDataAdapter(comando);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ConnectionDB.Close();
            gvProductos.DataSource = dt;
            gvProductos.DataBind();
        }

        [WebMethod]
        public static HttpStatusCodeResult actualizarOrden(int numero)
        {
            bool nonquery = ActualizarO(numero);

            if (nonquery == true)
            {
                return new HttpStatusCodeResult(200, "Orden actualizada correctamente!");
            }
            else
            {
                return new HttpStatusCodeResult(400, "Hubo un problema con la solicitud!");
            }
        }

        public static bool ActualizarO(int numero)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.Connection = ConnectionDB.Open();
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandText = "SPactualizarOrden";
                comando.Parameters.AddWithValue("@orden", Convert.ToInt32(numero));
                if (comando.ExecuteNonQuery() > 0)
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

        [WebMethod]
        public static HttpStatusCodeResult actualizarProductos(int Producto, int Cantidad, int Orden)
        {
            bool nonquery = ActualizarP(Producto, Cantidad, Orden);

            if (nonquery == true)
            {
                return new HttpStatusCodeResult(200, "Orden actualizada correctamente!");
            }
            else
            {
                return new HttpStatusCodeResult(400, "Hubo un problema con la solicitud!");
            }
        }

        public static bool ActualizarP(int Producto, int Cantidad, int Orden)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.Connection = ConnectionDB.Open();
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandText = "SPactualizarPO";
                comando.Parameters.AddWithValue("@orden", Convert.ToInt32(Orden));
                comando.Parameters.AddWithValue("@producto", Convert.ToInt32(Producto));
                comando.Parameters.AddWithValue("@cantidadRecibida", Convert.ToInt32(Cantidad));
                if (comando.ExecuteNonQuery() > 0)
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
    }
}