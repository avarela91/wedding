using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ET;

namespace VarelaRamirezWedding.Controllers
{
    public class HomeController : Controller
    {

        ContextCodigoMaster BD_CodigoMaster = new ContextCodigoMaster();
        ContextCodigoDetalle BD_CodigoDetalle = new ContextCodigoDetalle();
        // GET: Home
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Invitacion(string id)
        {
            List<CodigoMaster> master = new List<CodigoMaster>();
            if (id != null)
            {
                 master = BD_CodigoMaster.Select(new Dictionary<string, string> { { "Codigo", id.ToString() } });
                if (master.Count > 0)
                {
                    TempData["Familia"] = master[0].Familia.ToString();
                    TempData["Limite"] = master[0].Limite.ToString();
                    return View();
                }
                else
                {
                    TempData["Error"] = "Codigo no valido";
                    return RedirectToAction("Index", "Home");
                }

            }
            else
            {
                TempData["Error"] = "Debe ingresar un codigo para validar";
                return RedirectToAction("Index", "Home");
            }
        }
        // GET: Home/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Home/Create
        public ActionResult Create(string Codigo)
        {
            if (Codigo != null)
            {
                var master = BD_CodigoMaster.Select(new Dictionary<string, string>() { { "Codigo", Codigo.ToString() } });
                var cuposDisponibles = master[0].Limite - master[0].RegistrosActuales;
                ViewData["CodigoMaster"] = Codigo;
                //ViewData["msjCupos1"] = Codigo;
                ViewData["msjCupos1"] = "Numero de Invitados :" + master[0].Limite;
                ViewData["msjCupos2"] = "Cupos Confirmados :" + master[0].RegistrosActuales;
                ViewData["msjCupos3"] = "Cupos Disponibles " + cuposDisponibles;
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
            
        }


        public ActionResult about()
        {
            return View();
        }

        public ActionResult ModalValidateCode()
        {
            return View();
        }


        // POST: Home/Create
        [HttpPost]
        public JsonResult ModalValidateCode(string codigo)
        {
            var master = BD_CodigoMaster.Select(new Dictionary<string, string> { { "Codigo", codigo.ToString() } });
            var detalle = BD_CodigoDetalle.Select(new Dictionary<string, string> { { "CodigoMaster", codigo.ToString() } });
         
            if (master.Count != 0) {
                if (detalle.Count >= master[0].Limite  ){
                    return Json(new { respuesta = "El codigo ingresado ya no tiene mas cupos disponibles. Los "+master[0].Limite+" cupos ya han sido utilizados."}, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { respuesta = "Codigo Valido" }, JsonRequestBehavior.AllowGet);
                }
            }
            else{
                    return Json(new { respuesta = "Codigo Invalido" }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult ModalValidate()
        {
            return View();
        }


        // POST: Home/Create
        [HttpPost]
        public JsonResult ModalValidate(string codigo)
        {
            var master = BD_CodigoMaster.Select(new Dictionary<string, string> { { "Codigo", codigo.ToString() } });
            var detalle = BD_CodigoDetalle.Select(new Dictionary<string, string> { { "CodigoMaster", codigo.ToString() } });

            if (master.Count != 0)
            {
                //RedirectToAction("Invitacion", "Home");
                return Json(new { respuesta = "Codigo Valido" }, JsonRequestBehavior.AllowGet);

            }
            else
            {
                //RedirectToAction("Index", "Home");
                return Json(new { respuesta = "Codigo Invalido" }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpPost]
        public ActionResult Create(CodigoDetalle codigoDetalle)
        {
            try
            {
                // TODO: Add insert logic here
                if (ModelState.IsValid)
                {
                   
                    codigoDetalle.Activo = true;
                    object idDetalle = BD_CodigoDetalle.Insert(codigoDetalle, "");
                    object idMaster=
                    TempData["Message"] = "Guardado correctamente";
                    return RedirectToAction("Invitacion", "Home", new { id = codigoDetalle.CodigoMaster });
                }
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Error: " + ex.Message;
                return View();
            }
            return View();
        }

        // GET: Home/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Home/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Home/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Home/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
