using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace ET
{
    public class ContextCodigoDetalle:models<CodigoDetalle>
    {
        public ContextCodigoDetalle()
      : base("Id", "CodigoDetalle", "DefaultConnection")
        {
            ActivarRegistrodeUsuarioEnTransaccion = true;
            ActivarSoloRegistrosActivos = true;
        }
    }

    [Serializable()]
    public class CodigoDetalle : IClonable
    {
        public int Id { get; set; }
        public string CodigoMaster { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public bool RequiereHabitacion { get; set; }
        public bool Activo { get; set; }


        public object Clone()
        {
            return Utiles.Copia(this);
        }

    }
}
