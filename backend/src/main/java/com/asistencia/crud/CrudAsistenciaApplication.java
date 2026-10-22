package com.asistencia.crud;

import com.asistencia.crud.mapper.FeriadoMapper;
import com.asistencia.crud.model.Feriado;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.List;

@SpringBootApplication
public class CrudAsistenciaApplication {

	public static void main(String[] args) {
		SpringApplication.run(CrudAsistenciaApplication.class, args);
	}

	/* @Bean //registra un componente administrado por Spring.
	CommandLineRunner mostrarFeriados(FeriadoMapper mapper) { //ejecuta una tarea cuando Spring Boot termina de iniciar.

		return args -> {

			System.out.println("\n===== LISTA DE FERIADOS =====");

			List<Feriado> feriados = mapper.listarTodos();

			for (Feriado feriado : feriados) {

				System.out.println(
						"ID: " + feriado.getIdFeriado()
								+ " | Sucursal: " + feriado.getIdSucursal()
								+ " | Fecha: " + feriado.getFecha()
								+ " | Nombre: " + feriado.getNombre()
								+ " | Tipo: " + feriado.getTipo()
								+ " | Laborable: " + feriado.getLaborable()
								+ " | Estado: " + feriado.getEstado()
				);
			}

			System.out.println("=============================\n");
		};
	}*/
}
