$(document).ready(function(){
	$('#form-registro').submit(function(event){



		event.preventDefault();

		var mayorEdad = false;
		var contraIgual = false;

		var nombre = $('#registro-nombre').val();
		var apellidoPaterno = $('#registro-paterno').val();
		var apellidoMaterno = $('#registro-materno').val();
		var fecha = $('#registro-fecha').val();
		var sexo = $('input[name="registro-sexo"]:checked').val();
		var correo = $('#registro-correo').val();
		var tel = $('#registro-telefono').val();
		var nick = $('#registro-nick').val();
		var pass1 = $('#registro-password').val();
		var pass2 = $('#registro-password2').val();
		var perfil = $('#registro-foto1').val();
		var portada = $('#registro-foto2').val();

		var cumple = new Date(fecha);
		var fechaActual = new Date();
		var edad = fechaActual.getFullYear() - cumple.getFullYear();
		var mes = fechaActual.getMonth() - cumple.getMonth();

		if(mes < 0 || (mes === 0 && fechaActual.getDate() < cumple.getDate()))
		{
			edad--;
		}

		if(edad >= 18)
			mayorEdad = true;

		if(mayorEdad)
		{
			if(pass1.length < 8)
			{
				alert("La contraseña debe ser mayor a 8 caracteres");
			}else{				
				if(pass1 === pass2){

					re = /[0-9]/;
				    if(!re.test(pass1)) {
				    	alert("Error: ¿Y los numeritos?");
				    	return false;
				    }
					
					re = /[a-z]/;
					if(!re.test(pass1)) {
						alert("Error: Una minúscula no estaría mal.");
						return false;
				    }
				      
				    re = /[A-Z]/;
				    if(!re.test(pass1)) {
				    	alert("Error: Eyy! Listen! ¿Qué tienen de malo las mayúsculas? Usa una almenos.");
				    	return false;
				    }

				    contraIgual = true;
				}
				else{
					alert("Las contraseñas deben ser iguales");
					return false;
				}

				
			}
		}else{
			alert("Debes ser mayor de edad");			
		}


		if(contraIgual)
		{
			alert("OK!");
		}

	});
});