<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('alumnos', function (Blueprint $table) {
            $table->foreign('cod_nivel')->references('cod_nivel')->on('nivel');
        });

        Schema::table('educadores', function (Blueprint $table) {
            $table->foreign('cod_nivel')->references('cod_nivel')->on('nivel');
        });

        Schema::table('historial', function (Blueprint $table) {
            $table->foreign('rut_alumno')->references('rut')->on('alumnos');
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        
    }
};
