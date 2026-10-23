package com.asistencia.crud.mapper;

import com.asistencia.crud.model.Feriado;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FeriadoMapper {

    public static final String SELECT_BASE = """
        SELECT
            f.id_feriado,
            f.id_sucursal,
            f.fecha,
            f.nombre,
            f.tipo,
            f.laborable,
            f.estado
        FROM feriado f
        """;

    @Select(SELECT_BASE)
    List<Feriado> listarTodos();

    @Select(SELECT_BASE + """
            WHERE f.id_feriado = #{id}
            """)
    Feriado buscarPorId(@Param("id") Integer id);

    @Insert("""
        INSERT INTO feriado (
            id_sucursal,
            fecha,
            nombre,
            tipo,
            laborable,
            estado
        )
        VALUES (
            #{idSucursal},
            #{fecha},
            #{nombre},
            #{tipo},
            #{laborable},
            #{estado}
        )
    """)
    @Options(
            useGeneratedKeys = true,
            keyProperty = "idFeriado",
            keyColumn = "id_feriado"
    )
    int registrar(Feriado feriado);

    @Update("""
        UPDATE feriado
        SET
            id_sucursal = #{idSucursal},
            fecha = #{fecha},
            nombre = #{nombre},
            tipo = #{tipo},
            laborable = #{laborable},
            estado = #{estado}
        WHERE id_feriado = #{idFeriado}
    """)
    int actualizar(Feriado feriado);

    @Delete("""
    DELETE FROM feriado
    WHERE id_feriado = #{id}
    """)
    int eliminar(@Param("id") Integer id); // Identificamos explícitamente el nombre del parámetro

}
