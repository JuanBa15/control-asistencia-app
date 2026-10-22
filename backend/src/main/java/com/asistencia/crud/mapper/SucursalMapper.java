package com.asistencia.crud.mapper;

import com.asistencia.crud.model.Sucursal;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SucursalMapper {

    @Select("""
        SELECT 
            id_sucursal, 
            nombre, 
            pais, 
            ciudad, 
            zona_horaria, 
            estado, 
            fecha_creacion
        FROM sucursal
        """)
    List<Sucursal> listarTodos();

    @Select("""
        SELECT 
            id_sucursal, 
            nombre, 
            pais, 
            ciudad, 
            zona_horaria, 
            estado, 
            fecha_creacion
        FROM sucursal
        WHERE id_sucursal = #{id}
        """)
    Sucursal buscarPorId(@Param("id") Integer id);

    @Insert("""
        INSERT INTO sucursal (
            nombre, 
            pais, 
            ciudad, 
            zona_horaria, 
            estado
        )
        VALUES (
            #{nombre}, 
            #{pais}, 
            #{ciudad}, 
            #{zonaHoraria}, 
            #{estado})
        """)
    @Options(
            useGeneratedKeys = true,
            keyProperty = "idSucursal",
            keyColumn = "id_sucursal"
    )
    int registrar(Sucursal sucursal);

    @Update("""
        UPDATE sucursal
        SET nombre = #{nombre},
            pais = #{pais},
            ciudad = #{ciudad},
            zona_horaria = #{zonaHoraria},
            estado = #{estado}
        WHERE id_sucursal = #{idSucursal}
        """)
    int actualizar(Sucursal sucursal);

    @Delete("""
        DELETE FROM sucursal
        WHERE id_sucursal = #{id}
        """)
    int eliminar(@Param("id") Integer id);
}
