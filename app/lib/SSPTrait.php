<?php

namespace App\Lib;

trait SSPTrait
{
    /**
     * Perform the SQL queries needed for an server-side processing requested,
     * utilising the helper functions of this class, limit(), order() and
     * filter() among others. The returned array is ready to be encoded as JSON
     * in response to an SSP request, or can be modified if needed before
     * sending back to the client.
     *
     *  @param  array $request Data sent to server by DataTables
     *  @param  string $table SQL table to query
     *  @param  string $primaryKey Primary key of the table
     *  @param  array $columns Column information array
     *  @return array          Server-side processing response array
     */
    static function simple2($request, $con, $table, $primaryKey, $columns)
    {
        $bindings = array();
        $db = $con;

        // Build the SQL query string from the request
        $limit = self::limit($request, $columns);
        $order = self::order($request, $columns);
        $where = self::filter($request, $columns, $bindings);

        // Main query to actually get the data
        $data = self::sql_exec(
            $db,
            $bindings,
            "SELECT `" . implode("`, `", self::pluck($columns, 'db')) . "`
			 FROM `$table`
			 $where
			 $order
			 $limit"
        );

        // Data set length after filtering
        $resFilterLength = self::sql_exec(
            $db,
            $bindings,
            "SELECT COUNT(`{$primaryKey}`)
			 FROM   `$table`
			 $where"
        );
        $recordsFiltered = $resFilterLength[0][0];

        // Total data set length
        $resTotalLength = self::sql_exec(
            $db,
            "SELECT COUNT(`{$primaryKey}`)
			 FROM   `$table`"
        );
        $recordsTotal = $resTotalLength[0][0];

        /*
		 * Output
		 */
        return array(
            "draw"            => isset($request['draw']) ?
                intval($request['draw']) :
                0,
            "recordsTotal"    => intval($recordsTotal),
            "recordsFiltered" => intval($recordsFiltered),
            "data"            => self::data_output($columns, $data)
        );
    }

    static function complex2($request, $con, $table, $primaryKey, $columns, $whereResult = null, $whereAll = null)
	{
		$bindings = array();
		$whereAllBindings = array();
		$db = $con;
		$whereAllSql = '';
		
		// Build the SQL query string from the request
		$limit = self::limit($request, $columns);
		$order = self::order($request, $columns);
		$where = self::filter($request, $columns, $bindings);

		// whereResult can be a simple string, or an assoc. array with a
		// condition and bindings
		if ($whereResult) {
			$str = $whereResult;

			if (is_array($whereResult)) {
				$str = $whereResult['condition'];

				if (isset($whereResult['bindings'])) {
					self::add_bindings($bindings, $whereResult['bindings']);
				}
			}

			$where = $where ?
				$where . ' AND ' . $str :
				'WHERE ' . $str;
		}

		// Likewise for whereAll
		if ($whereAll) {
			$str = $whereAll;

			if (is_array($whereAll)) {
				$str = $whereAll['condition'];

				if (isset($whereAll['bindings'])) {
					self::add_bindings($whereAllBindings, $whereAll['bindings']);
				}
			}

			$where = $where ?
				$where . ' AND ' . $str :
				'WHERE ' . $str;

			$whereAllSql = 'WHERE ' . $str;
		}

        $data = self::sql_exec(
			$db,
			$bindings,
			"SELECT " . implode(", ", self::pluck($columns, 'db')) . "
			 FROM $table
			 $where
			 $order
			 $limit"
		);

		// Data set length after filtering
		$resFilterLength = self::sql_exec(
			$db,
			$bindings,
			"SELECT COUNT({$primaryKey})
			 FROM   $table
			 $where"
		);
		$recordsFiltered = $resFilterLength[0][0];

		// Total data set length
		$resTotalLength = self::sql_exec(
			$db,
			$whereAllBindings,
			"SELECT COUNT({$primaryKey})
			 FROM   $table " .
				$whereAllSql
		);
		$recordsTotal = $resTotalLength[0][0];

		/*
		 * Output
		 */
		return array(
			"draw"            => isset($request['draw']) ?
				intval($request['draw']) :
				0,
			"recordsTotal"    => intval($recordsTotal),
			"recordsFiltered" => intval($recordsFiltered),
			"data"            => self::data_output($columns, $data)
		);
	}
}
