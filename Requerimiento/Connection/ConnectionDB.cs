using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Requerimiento.Connection
{
    public static class ConnectionDB
    {
        public static SqlConnection Open()
        {
            string connStr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = connStr;
            conexion.Open();
            return conexion;
        }

        public static SqlConnection Close()
        {
            string connStr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            SqlConnection conexion = new SqlConnection();
            conexion.ConnectionString = connStr;
            conexion.Close();
            return conexion;
        }
    }
}