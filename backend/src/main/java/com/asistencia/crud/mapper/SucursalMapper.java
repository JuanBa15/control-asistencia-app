package com.asistencia.crud.mapper;

import com.asistencia.crud.model.Sucursal;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface SucursalMapper {

    public static final String SELECT_BASE = """
        SELECT
            s.id_sucursal,
            s.nombre,
            s.pais,
            s.ciudad,
            s.zona_horaria,
            s.estado,
            s.fecha_creacion
        FROM sucursal s
        """;

    @Select(SELECT_BASE)
    List<Sucursal> listarTodos();

    @Select(SELECT_BASE + """
        WHERE s.id_sucursal = #{id}
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
