<?

$dir = "arquivos/";

class Dir2Xml
{
	function __construct($dir)
	{
		$this->dir = $dir;
	}
	
	function __toString()
	{
		$di = new RecursiveDirectoryIterator($this->dir);
		return $this->recursive($di);
	}

	function recursive($di, $indent = 0)
	{
		$name = basename($di->getPath());
		$xml = $this->i($indent)."<$name>\n";
		foreach($di as $item):
			if ($item->isDir()):
				$xml .= $this->recursive($di->getChildren(), $indent + 1);
			else:
				$file = $item->getFilename();
				$id = pathinfo($file, PATHINFO_FILENAME);
				$dir = $this->p($item->getPath());
				$path = $this->p($item->getPathname());
				$xml .= str_repeat("\t", $indent + 1).<<<XML
<file id="$id" name="$file" dir="$dir/" path="$path" />

XML;
			endif;
		endforeach;
		$xml .= $this->i($indent)."</$name>\n";
		return $xml;
	}

	private function i($indent)
	{
		return str_repeat("\t", $indent);
	}

	private function p($path)
	{
		return strtr($path, "\\", "/");
	}
}

$xml = new Dir2Xml($dir);
echo $xml;
file_put_contents("arquivos.xml", $xml);

?>