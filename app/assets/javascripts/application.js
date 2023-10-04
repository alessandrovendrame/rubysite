//= require prototype.js
//= require effects.js
//= require dragdrop.js
//= require controls.js
//= require lowpro.js

function setupTable(id) {
	var table = document.getElementById(id);
	var headerRow = table.tHead.rows[0].cells;
	var rows = table.tBodies[0].rows;
	for (var rowLoop=0; rowLoop<rows.length; rowLoop++) {
		for (var cellLoop=0; cellLoop<headerRow.length; cellLoop++) {
			
			// if(headerRow[cellLoop].className.match('cut')){
			// 							rows[rowLoop].cells[cellLoop].className = 'cut';
			// 						}
			
			rows[rowLoop].cells[cellLoop].className = headerRow[cellLoop].className;
		}
	}
}

var trclick = true;

function gotToPage(p) {
  if (trclick) {
    window.location = p
  } else {
    trclick = true;
  }
}

function resetClick() {
  trclick = false;
}

function roundVal(val){
	var dec = 2;
	var result = Math.round(val*Math.pow(10,dec))/Math.pow(10,dec);
	return result;
}

function toDecimal(s) {
  var dec = 2;
  val = parseFloat(s.replace(",", "."));
  var result = Math.round(val*Math.pow(10,dec))/Math.pow(10,dec);
  if(isNaN(result)) {result = 0}
	return result;
}

function gross_register_a(t) {
  t.value = t.value.replace(",", ".");
  total = toDecimal($("register_a_net_stock").value)
    + toDecimal($("register_a_net_customs").value)
    + toDecimal($("register_a_net_transport").value)
    - toDecimal($("register_a_cost").value);
  $("register_a_gross").value = roundVal(total);
}

function gross_register_b(t) {  
  t.value = t.value.replace(",", ".");
  total = toDecimal($("register_b_net_stock").value)
    + toDecimal($("register_b_net_customs").value)
    + toDecimal($("register_b_net_transport").value)
    - toDecimal($("register_b_cost").value);
  $("register_b_gross").value = roundVal(total);
}

function gross_register_c(t) {  
  t.value = t.value.replace(",", ".");
  total = toDecimal($("register_c_net_stock").value)
    + toDecimal($("register_c_net_customs").value)
    + toDecimal($("register_c_net_transport").value)
    - toDecimal($("register_c_cost").value);
  $("register_c_gross").value = roundVal(total);
}

function gross_register_d(t) {  
  t.value = t.value.replace(",", ".");
  total = toDecimal($("register_d_net").value)
    - toDecimal($("register_d_cost").value);
  $("register_d_gross").value = roundVal(total);
}

function gross_register_e(t) {  
  t.value = t.value.replace(",", ".");

  if ($("register_e_date_1i").value >= 2021) {
    total = - toDecimal($("register_e_nole_cost").value)
    - toDecimal($("register_e_incidental_cost").value)
    + toDecimal($("register_e_net").value)
  } else {
    total = - toDecimal($("register_e_nole_cost").value)
    - toDecimal($("register_e_bl_cost").value)
    - toDecimal($("register_e_transport_cost").value)
    - toDecimal($("register_e_stop_cost").value)
    - toDecimal($("register_e_incidental_cost").value)
    + toDecimal($("register_e_net").value)
  }
  $("register_e_gross").value = roundVal(total);
}

