using Requerimiento.Connection;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Requerimiento.Vistas.Proveedor
{
    public partial class CrearProveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static HttpStatusCodeResult crearProveedor(string Nombre)
        {
            bool nonquery = Crear(Nombre);

            if (nonquery == true)
            {
                return new HttpStatusCodeResult(200, "Proveedor creado correctamente!");
            }
            else
            {
                return new HttpStatusCodeResult(400, "Hubo un problema con la solicitud!");
            }
        }

        public static bool Crear(string Nombre)
        {
            try
            {
                SqlCommand comando = new SqlCommand();
                comando.Connection = ConnectionDB.Open();
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.CommandText = "SPcrearProveedor";
                comando.Parameters.AddWithValue("@nombreProveedor", Convert.ToString(Nombre));
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