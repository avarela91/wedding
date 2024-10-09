using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace ET
{
    public class ContextCodigoMaster:models<CodigoMaster>
    {
        public ContextCodigoMaster()
       : base("Codigo", "CodigoMaster", "DefaultConnection")
        {
            ActivarRegistrodeUsuarioEnTransaccion = true;
            ActivarSoloRegistrosActivos = true;
        }
    }

    [Serializable()]
    public class CodigoMaster : IClonable
    {
        [DisplayName("Codigo de Verificacion")]
        public string Codigo { get; set; }
        public string Familia { get; set; }
        public int Limite { get; set; }
        public int RegistrosActuales { get; set; }
        public bool Activo { get; set; }


        public object Clone()
        {
            return Utiles.Copia(this);
        }

    }
}
