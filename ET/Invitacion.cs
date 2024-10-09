using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace ET
{
    public class ContextInvitacion:models<Invitacion>
    {
        public ContextInvitacion()
        : base("Codigo", "CodigoMaster", "DefaultConnection")
        {
            ActivarRegistrodeUsuarioEnTransaccion = true;
            ActivarSoloRegistrosActivos = true;
        }

         

    }

    [Serializable()]
    public class Invitacion : IClonable
    {
        [DisplayName("Codigo de Verificacion")]
        public int Codigo { get; set; }


        public object Clone()
        {
            return Utiles.Copia(this);
        }

    }
}
