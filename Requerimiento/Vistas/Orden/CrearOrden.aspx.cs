using Requerimiento.Connection;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Requerimiento.Vistas.Orden
{
    public partial class CrearOrden : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                llenarProveedores();
                llenarProductos();
                generarNumero();
            }
        }

        public void llenarProveedores()
        {
            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPlistarProveedor";
            SqlDataAdapter da = new SqlDataAdapter(comando);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddlProveedor.DataSource = ds;
            ddlProveedor.DataTextField = "texto";
            ddlProveedor.DataValueField = "nit";
            ddlProveedor.DataBind();
            ddlProveedor.Items.Insert(0, new ListItem("-- Seleccione el Proveedor --", ""));
            ddlProveedor.Items[0].Attributes["selected"] = "selected";
            ddlProveedor.Items[0].Attributes["disabled"] = "disabled";
            ConnectionDB.Close();
        }

        public void llenarProductos()
        {
            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPlistarProductos";
            SqlDataAdapter da = new SqlDataAdapter(comando);
            DataSet ds = new DataSet();
            da.Fill(ds);
            sltProducto.DataSource = ds;
            sltProducto.DataTextField = "texto";
            sltProducto.DataValueField = "codigoProducto";
            sltProducto.DataBind();
            ConnectionDB.Close();
        }

        public void generarNumero()
        {
            SqlCommand comando = new SqlCommand();
            comando.Connection = ConnectionDB.Open();
            comando.CommandType = System.Data.CommandType.StoredProcedure;
            comando.CommandText = "SPRandomGenerator";
            IDbDataParameter parametro = comando.CreateParameter();
            parametro.ParameterName = "@salida";
            parametro.Direction = System.Data.ParameterDirection.Output;
            parametro.DbType = System.Data.DbType.String;
            parametro.Size = 50;
            comando.Parameters.Add(parametro);
            comando.ExecuteNonQuery();
            txtNumeroOrden.Text = Convert.ToString(parametro.Value);
        }

        [WebMethod]
        public static HttpStatusCodeResult CrearProductosEnOrden(int Producto, int Cantidad, decimal Precio, int Orden)
        {
            bool nonquery = CrearP(Producto, Cantidad, Precio, Orden);

            if (nonquery == true)
            {
                return new HttpStatusCodeResult(200, "Orden creada correctamente!");
            }
            else
            {
                return new HttpStatusCodeResult(400, "Hubo un problema con la solicitud!");
            }
        }

        public static bool CrearP(int Producto, int Cantidad, decimal Precio, int Orden)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.Connection = ConnectionDB.Open();
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandText = "SPproductosEnOrden";
                comando.Parameters.AddWithValue("@orden", Convert.ToInt32(Orden));
                comando.Parameters.AddWithValue("@producto", Convert.ToInt32(Producto));
                comando.Parameters.AddWithValue("@cantidadPedida", Convert.ToInt32(Cantidad));
                comando.Parameters.AddWithValue("@precio", Convert.ToDecimal(Precio));
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
        public static HttpStatusCodeResult generarOrden(int numero, DateTime fechaOrden, int Proveedor, DateTime fechaEntrega)
        {
            bool nonquery = Crear(numero, fechaOrden, Proveedor, fechaEntrega);

            if (nonquery == true)
            {
                return new HttpStatusCodeResult(200, "Orden creada correctamente!");
            }
            else
            {
                return new HttpStatusCodeResult(400, "Hubo un problema con la solicitud!");
            }
        }

        public static bool Crear(int numero, DateTime fechaOrden, int Proveedor, DateTime fechaEntrega)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.Connection = ConnectionDB.Open();
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandText = "SPcrearOrden";
                comando.Parameters.AddWithValue("@numero", Convert.ToInt32(numero));
                comando.Parameters.AddWithValue("@fechaOrden", Convert.ToDateTime(fechaOrden));
                comando.Parameters.AddWithValue("@proveedor", Convert.ToInt32(Proveedor));
                comando.Parameters.AddWithValue("@fechaEntrega", Convert.ToDateTime(fechaEntrega));
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